Return-Path: <linux-kernel-owner+w=401wt.eu-S932076AbXAFS6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbXAFS6B (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbXAFS6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:58:00 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:40833 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076AbXAFS6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:58:00 -0500
Subject: Re: libata error handling
From: Kasper Sandberg <lkml@metanurb.dk>
To: Robert Hancock <hancockr@shaw.ca>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <459FE8BE.7070208@shaw.ca>
References: <fa.pdj7pJD9C08bRZatFINV1hz1oyA@ifi.uio.no>
	 <459FE8BE.7070208@shaw.ca>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 19:57:54 +0100
Message-Id: <1168109874.1512.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 12:21 -0600, Robert Hancock wrote:
> Kasper Sandberg wrote:
> > i have heard that libata has much better error handling (this is what
> > made me try it), and from initial observations, that appears to be very
> > true, however, im wondering, is there something i can do to get
> > extremely verbose information from libata? for example if it corrects
> > errors? cause i'd really like to know if it still happens, and if i
> > perhaps get corruption as before, even though not severe.
> 
> Any errors, timeouts or retries would be showing up in dmesg..
how sure can i be of this? is it 100% sure that i have not encountered
this error then?
> 

