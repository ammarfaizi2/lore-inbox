Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293627AbSCUJGD>; Thu, 21 Mar 2002 04:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293626AbSCUJFw>; Thu, 21 Mar 2002 04:05:52 -0500
Received: from mail.webmaster.com ([216.152.64.131]:18569 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S293619AbSCUJFu> convert rfc822-to-8bit; Thu, 21 Mar 2002 04:05:50 -0500
From: David Schwartz <davids@webmaster.com>
To: <flygong@yahoo.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Thu, 21 Mar 2002 01:05:47 -0800
In-Reply-To: <20020321051219.9811.qmail@web14510.mail.yahoo.com>
Subject: Re: The network performance of linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020321090548.AAA17336@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Mar 2002 21:12:19 -0800 (PST), Bergs wrote:

>I work on a linux 2.2.14 kernel to test the network
>throughput of a linux  box used as a firewall.

>I find that when the IP packet length is 512B,the
>throughput is the highest 71%. IP packet length is
>smaller than 512B or bigger than 512B,the throughput
>is the lower.

>I don't know why this ? Can I have some solutions
>to improve the throughput of linux box ?

	I don't understand what you're measuring. Are you using TCP or UDP? If UDP, 
what exactly are you measuring? If TCP, how are you changing the packet size?

