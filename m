Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbVIBAQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbVIBAQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 20:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbVIBAQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 20:16:52 -0400
Received: from [195.23.16.24] ([195.23.16.24]:21175 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S1030590AbVIBAQv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 20:16:51 -0400
Message-ID: <1125619916.431798cced77b@webmail.grupopie.com>
Date: Fri,  2 Sep 2005 01:11:56 +0100
From: "" <pmarques@grupopie.com>
To: "" <sabujp@gmail.com>
Cc: "" <linux-kernel@vger.kernel.org>
Subject: Re: Inconsistent kallsyms data error near the end of make in the linux kernel-2.6.13
References: <e6467158050901170059d5c53c@mail.gmail.com>
In-Reply-To: <e6467158050901170059d5c53c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.88.18
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sabuj Pattanayek <sabujp@gmail.com>:

> Hi all,

Hi, Sabuj

> I'm posting a bug as directed by REPORTING-BUGS in the kernel sources.
> 
> PROBLEM: Inconsistent kallsyms data error near the end of make in the linux
> kernel-2.6.13 .

This is probably a known problem.

Please check this thread:

http://lkml.org/lkml/2005/8/31/129

and use the patch I posted there.

I hope this helps,

--
Paulo Marques

