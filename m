Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264759AbUDWIat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264759AbUDWIat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 04:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264760AbUDWIat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 04:30:49 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:61883 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S264759AbUDWIas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 04:30:48 -0400
Date: Fri, 23 Apr 2004 10:30:41 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: nvidia binary driver broken with 2.6.6-rc{1,2}, reverting a -mm patch makes it work
Message-ID: <20040423083041.GK8599@charite.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <4088D1E3.1050901@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4088D1E3.1050901@xs4all.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Ballegooijen <sleightofmind@xs4all.nl>:
> Hi,
> 
> Because of a patch from -mm merged in mainstream i cannot get the nvidia
> binary to work with the 2.6.6 release candidates. I get this message
> when doing `modprobe nvidia`:

$ uname -a
Linux hummus2 2.6.6-rc2-bk1 #1 Thu Apr 22 14:15:08 CEST 2004 i686
GNU/Linux

nvidia works like a charm here.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
