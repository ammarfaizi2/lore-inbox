Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbTFMSgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbTFMSgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:36:05 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:34697 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S265162AbTFMSgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:36:03 -0400
Date: Fri, 13 Jun 2003 12:49:38 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org, "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: 2.4.21-uv1 patch released
In-Reply-To: <20030613114249.6769b3fc.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0306131246020.9166-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Randy.Dunlap wrote:

> I can't boot 2.4.21 without the latest aic7xyz tarball applied,
> from http://people.FreeBSD.org/~gibbs/linux/SRC/
> 
> The 2.4.21 driver just hangs during boot.

Nifty...

Justin, is this a confirmed problem with the aic79xx driver in 2.4.21 and is
there a 2.4.21-rc8 or later patch that will go in clean?  (I'm thinking the
2.4-20030603 patch should).

Thanks,
James

> 
> --
> ~Randy
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  


