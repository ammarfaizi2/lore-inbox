Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264201AbUD0RFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbUD0RFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUD0RFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:05:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:34273 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264201AbUD0RFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:05:41 -0400
Date: Tue, 27 Apr 2004 19:05:33 +0200
From: "Juergen E. Fischer" <fischer@linux-buechse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040427170533.GB9574@linux-buechse.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <408DC0E0.7090500@gmx.net> <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org> <1083045844.2150.105.camel@bach> <20040427092159.GC29503@lug-owl.de> <408E37D9.7030804@gmx.net> <408E5944.8090807@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <408E5944.8090807@grupopie.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:8b0c050ff9179508392b54e1b921775e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paulo,

On Tue, Apr 27, 2004 at 13:59:48 +0100, Paulo Marques wrote:
> The way I see it, they know a C string ends with a '\0'. This is like 
> saying that a English sentence ends with a dot. If they wrote "GPL\0" they 
> are effectively saying that the license *is* GPL period.
> 
> So, where the source code? :)

IANAL, but I think the copyright holder is not bound to the GPL and can
supply what ever he wants, just the licensee is required to make the
source available.

Jürgen
