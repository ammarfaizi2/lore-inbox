Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274200AbRJEWGW>; Fri, 5 Oct 2001 18:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274198AbRJEWGM>; Fri, 5 Oct 2001 18:06:12 -0400
Received: from mail.webmaster.com ([216.152.64.131]:1990 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S274196AbRJEWF6> convert rfc822-to-8bit; Fri, 5 Oct 2001 18:05:58 -0400
From: David Schwartz <davids@webmaster.com>
To: <knuffie@xs4all.nl>, Rik van Riel <riel@conectiva.com.br>
CC: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, <linux-xfs@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (988) - Registered Version
Date: Fri, 5 Oct 2001 15:06:25 -0700
In-Reply-To: <Pine.BSI.4.10.10110052208390.303-100000@xs3.xs4all.nl>
Subject: Re: %u-order allocation failed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20011005220627.AAA22897@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The system is beafy enough to tolerate something mundane as this. It should
>definitely not die.

	A fork bomb with no limits attempts to create an infinite number of 
processes. No system can be that beefy.

	DS


