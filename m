Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262008AbSJITDw>; Wed, 9 Oct 2002 15:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbSJITDu>; Wed, 9 Oct 2002 15:03:50 -0400
Received: from edinburgh.cisco.com ([144.254.112.76]:7578 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S261920AbSJITCv>;
	Wed, 9 Oct 2002 15:02:51 -0400
Date: Wed, 9 Oct 2002 20:05:53 +0100
From: Derek Fawcus <dfawcus@cisco.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for testers with these NICs
Message-ID: <20021009200553.I29133@edinburgh.cisco.com>
References: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Oct 09, 2002 at 07:31:17PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 07:31:17PM -0200, Denis Vlasenko wrote:
> ni65.c

I've got some of these knocking about,  but rather than use that driver,
I have a (quite old) patch,  that allows the normal lance driver to be
used.  The patch dates back from 1.3.x,  but I think I may have a more
recent version around.

DF
