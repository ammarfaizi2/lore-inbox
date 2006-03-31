Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWCaBKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWCaBKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWCaBKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:10:40 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:28557 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751096AbWCaBKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:10:39 -0500
Date: Thu, 30 Mar 2006 19:09:39 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: How to debug an Oops on  FC4 2.6 Kernel
In-reply-to: <5WbMU-6U1-67@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Peter Van <plst@ws.sbcoxmail.com>
Message-id: <442C8153.1050907@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5WbMU-6U1-67@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Van wrote:
> Hi,
> 
> My computer hung af few day ago for no apparent  reason requiring a 
> reboot and clear.
> /var/log/messages has an  Oops log but I don't know how to use the Oops 
> log to determine the cause of the problem.  According to some posts,  
> ksymoops can't be used
> on a 2.6 kernel.

That's because it's not needed, the oops already shows the symbols.

That's a somewhat old FC4 kernel now, you could try the latest version.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

