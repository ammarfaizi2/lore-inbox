Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132622AbRAXGMn>; Wed, 24 Jan 2001 01:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRAXGMd>; Wed, 24 Jan 2001 01:12:33 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:64274 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S132622AbRAXGMV>;
	Wed, 24 Jan 2001 01:12:21 -0500
Date: Tue, 23 Jan 2001 22:12:13 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net,
        Linux-usb-users@lists.sourceforge.net
Subject: 2001-01-23 release of hotplug scripts
Message-ID: <20010123221213.A19568@kroah.com>
In-Reply-To: <20010116225518.C1733@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010116225518.C1733@kroah.com>; from greg@kroah.com on Tue, Jan 16, 2001 at 10:55:18PM -0800
X-Operating-System: Linux 2.2.18-immunix (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest hotplug scripts into a release, and
they can be found at:
	http://download.sourceforge.net/linux-hotplug/hotplug-2001_01_23.tar.gz
	http://download.sourceforge.net/linux-hotplug/hotplug-2001_01_23-1.noarch.rpm
 	http://download.sourceforge.net/linux-hotplug/hotplug-2001_01_23-1.src.rpm
depending on which format you prefer.

Changes in this version from the last release are:
	- log "ifup" invocations when debugging for net.agent script
	- address some problems with hotplugging USB on 2.2
	- small change in the .spec file from Chmouel Boudjnah

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
