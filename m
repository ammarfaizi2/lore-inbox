Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265498AbTFMTac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbTFMTac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:30:32 -0400
Received: from kwisatz.net1.nerim.net ([80.65.225.31]:43531 "EHLO
	www.rubis.org") by vger.kernel.org with ESMTP id S265498AbTFMTab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:30:31 -0400
Date: Fri, 13 Jun 2003 21:43:15 +0200
From: Stephane Jourdois <stephane@rubis.org>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Subject: Re: CD-ROM not showing up in /dev with devfs
Message-ID: <20030613194315.GA31520@rubis.org>
Reply-To: stephane@rubis.org
References: <20030613184649.GA12113@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030613184649.GA12113@the-penguin.otak.com>
X-Operating-System: Linux 2.4.21-pre5-ac3
X-Send-From: www.rubis.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 11:46:49AM -0700, Lawrence Walton wrote:
> SCSI CD-ROM not showing up in /dev with devfs
> Compiled in or as a module no cdrom device is shown.

try modprobe sr_mod

Cordially,

-- 
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ingénieur développement 	\ /    AGAINST HTML MAIL    )))
 \\\   24, rue Cauchy	         X                         ///
  \\\  75015  Paris             / \    +33 6 8643 3085    ///
