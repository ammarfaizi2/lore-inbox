Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWG1SGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWG1SGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWG1SGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:06:44 -0400
Received: from unassigned-87.236.194.20.coolhousing.net ([87.236.194.20]:49929
	"EHLO mail.agmk.net") by vger.kernel.org with ESMTP
	id S1161161AbWG1SGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:06:43 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
Date: Fri, 28 Jul 2006 20:06:22 +0200
User-Agent: KMail/1.9.3
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607281913.37889.pluto@agmk.net> <m2psfpy5ob.fsf@vador2.mandriva.com>
In-Reply-To: <m2psfpy5ob.fsf@vador2.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282006.22750.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 19:56, Thierry Vignaud wrote:

> thus this won't protect stacks of small functions... such as your
> example...

i've tested it with -fstack-protector-all
