Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130037AbRBSMB0>; Mon, 19 Feb 2001 07:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129384AbRBSMBH>; Mon, 19 Feb 2001 07:01:07 -0500
Received: from lech.pse.pl ([194.92.3.7]:61574 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S130097AbRBSMAz>;
	Mon, 19 Feb 2001 07:00:55 -0500
Date: Mon, 19 Feb 2001 13:00:44 +0100
From: Lech Szychowski <lech.szychowski@pse.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: quotaon -guav on 2.4.1-ac15
Message-ID: <20010219130044.D13053@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <NDBBKKONDOBLNCIOPCGHAEPCEMAA.vhou@khmer.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <NDBBKKONDOBLNCIOPCGHAEPCEMAA.vhou@khmer.cc>; from vhou@khmer.cc on Fri, Feb 16, 2001 at 05:59:22AM -0800
Organization: Polskie Sieci Elektroenergetyczne S.A.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> quotaon: using /home/vhosts/b/quota.user on /dev/sda3: Invalid argument
> quotaon: using /home/vhosts/a/quota.user on /dev/sdb1: Invalid argument

I believe -ac family has Jan Kara quota patches and
therefore you need his quota-3 utilites, avaliable from
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
