Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272060AbTG1CBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272057AbTG1ABL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:11 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:49539 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id S272689AbTG0XTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:19:01 -0400
Date: Mon, 28 Jul 2003 01:37:48 +0100 (BST)
From: James Stevenson <james@stev.org>
To: Doruk Fisek <dfisek@fisek.com.tr>
cc: linux-kernel@vger.kernel.org
Subject: Re: hw tcp v4 csum failed
In-Reply-To: <20030727100246.4bfb860c.dfisek@fisek.com.tr>
Message-ID: <Pine.LNX.4.44.0307280135420.4847-100000@jlap.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
> 
>  I am getting "hw tcp v4 csum failed" errors using a BCM5701 ethernet
> adapter with the tigon3 driver in a vanilla 2.4.20 kernel.
> 
>  There seems to be no apparent problem (probably because of low-load).
> 
>  What can be the cause of these errors?
 
if it isnt a software problem.

Its probably a problem releated to the cable or surrounding
interference on the cable.

a) loose connection either on back of machine or @ the hub / switch etc..
b) there is a large power supply sitting very close to the cable.
   i have seen the transformers on scanners / printers etc.. strong enough
   todo this is the cable gets wrapped around it

	James 

