Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751987AbWG1IsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbWG1IsQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbWG1IsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:48:16 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:6303 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S1751987AbWG1IsQ (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 28 Jul 2006 04:48:16 -0400
Message-ID: <44C96CC7.9050808@namesys.com>
Date: Thu, 27 Jul 2006 19:47:51 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andrea@cpushare.com
CC: Adrian Bunk <bunk@stusta.de>, "J. Bruce Fields" <bfields@fieldses.org>,
       Nikita Danilov <nikita@clusterfs.com>, Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <20060726132957.GH32243@opteron.random> <20060726134326.GD23701@stusta.de> <20060726142854.GM32243@opteron.random> <20060726145019.GF23701@stusta.de> <20060726160604.GO32243@opteron.random> <20060726170236.GD31172@fieldses.org> <20060726172029.GS32243@opteron.random> <20060726205022.GI23701@stusta.de> <20060726211741.GU32243@opteron.random> <20060727065603.GJ23701@stusta.de> <20060727115229.GD32243@opteron.random>
In-Reply-To: <20060727115229.GD32243@opteron.random>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrea@cpushare.com wrote:

>
>
>As far as I'm concerned the thing I like less of reiser4 is the plugin
>thing, I'd be less concerned if that was a microkernel (fuse-like)
>userland plugin system. 
>

Performance.  If your plugin is performance valuing, it needs to be in
kernel.   Also, FUSE does not have per-file plugins (correct me if I err
here).  It would be nice to see it pay attention to reiser4 pluginids,
and thus become per-file.

Thanks for your other words, which I will not comment on because I agree
with them.;-)
