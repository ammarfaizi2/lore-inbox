Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVBLAs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVBLAs7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 19:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVBLAs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 19:48:59 -0500
Received: from relay.axxeo.de ([213.239.199.237]:10723 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S262371AbVBLAs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 19:48:57 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Date: Sat, 12 Feb 2005 01:48:49 +0100
User-Agent: KMail/1.7.1
Cc: andersen@codepoet.org, Christian Borntr?ger <christian@borntraeger.net>,
       Bill Nottingham <notting@redhat.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050211004033.GA26624@suse.de> <20050211230657.B1635@banaan.localdomain> <20050211221323.GC23606@suse.de>
In-Reply-To: <20050211221323.GC23606@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502120148.50073.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Greg KH write:
> Very nice stuff.  Ok, that's a good reason not to get rid of these
> files, although they can be generated on the fly from the modules
> themselves (like depmod does it.)

Time to resurrect modinfo? ;-)
Didn't we plan to get rid of that, too?

If we like to use information from modules, there should be a scriptable 
tool to extract this kind of information, otherwise it will be a bitch to 
maintain those tools.


Regards

Ingo Oeser

