Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbVF3UzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbVF3UzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVF3UzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:55:10 -0400
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:58756
	"HELO fargo") by vger.kernel.org with SMTP id S263086AbVF3UwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:52:06 -0400
Date: Thu, 30 Jun 2005 22:48:32 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
Message-ID: <20050630204832.GA3854@fargo>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy> <20050630193320.GA1136@fargo> <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On Jun 30 at 09:39:47, Anton Altaparmakov wrote:
> > I tested it again, wchan says "inode_wait"...
> 
> Do you have any ntfs volumes mounted by any chance? 

No, just ext2

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
