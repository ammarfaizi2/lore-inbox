Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132413AbREBIvy>; Wed, 2 May 2001 04:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbREBIvp>; Wed, 2 May 2001 04:51:45 -0400
Received: from digger1.defence.gov.au ([203.5.217.4]:13222 "EHLO
	digger1.defence.gov.au") by vger.kernel.org with ESMTP
	id <S132413AbREBIvc>; Wed, 2 May 2001 04:51:32 -0400
Message-ID: <2149A0BABC77D311AF890090274E00B2024C9F14@salex005.dsto.defence.gov.au>
From: "Shahin, Mofeed" <Mofeed.Shahin@dsto.defence.gov.au>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Ati Rage 128 problems.
Date: Wed, 2 May 2001 18:15:45 +0930 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,

I have a laptop (Dell Inspiron 8000) which has an Ati M4 Mobility.
The problem happens whan I try to do 3D stuff on it.
The example I am using is quake2 pointing at the Mesa GL drivers. (Redhat
7.1)
I get about 5-15 seconds into the demo when the whole machine locks up. It
sometimes comes back and says something along the lines of ~"R128 timed
out".
Some times I even get a message in /var/log/messages along the lines of 
"error in r128_flush_pixmap_cache" or something like that.
I don't have the laptop in front of me at the moment, and that is why my
recollection of the error messages is not precise.

I am wandering if this is a known bug, or new one, or if I am to blame.

BTW : I am running Redhat 7.1 with 2.4.2-2.

Mof.
