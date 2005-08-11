Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVHKWob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVHKWob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVHKWob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:44:31 -0400
Received: from mail.portrix.net ([212.202.157.208]:58839 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S932497AbVHKWoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:44:30 -0400
Message-ID: <42FBD4B4.2060400@ppp0.net>
Date: Fri, 12 Aug 2005 00:44:04 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Thunderbird/1.0.6 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: akpm@osdl.org, blaisorblade@yahoo.it, linux-kernel@vger.kernel.org,
       jdike@addtoit.com
Subject: Re: UML build broken on 2.6.13-rc5-mm1
References: <E1E3HxJ-0003Uf-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1E3HxJ-0003Uf-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> UML is broken again in -mm.
> 
> Maybe UML should be added to one of the automatic build suites.

It is, see here: http://l4x.org/k/?d=6080 . But the maintainer (if he cares)
will know that it's broken and send a fix in time.
-mm is imho designed to be broken from time to time.

-- 
Jan
