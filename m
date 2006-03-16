Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752222AbWCPV3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbWCPV3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWCPV3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:29:05 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:4107 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752370AbWCPV3D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:29:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RUkZ5xRosGZf4yepcmQkHgNsB2V0kMiTkSMrMfrchv4CINpX68bHg8tUmL7AoiJMkY84M0YbUF36++5WtQuDk5oCfqSHLsOoDCDcGEuIOehKH/dwv5m3iiG2RLMam4cxz0cAW18rQK2W2mAqwtC4NKGYTEpc4+AvtJA/FVUkSsQ=
Message-ID: <bda6d13a0603161328q26d7abb6v718178c30e27ef6b@mail.gmail.com>
Date: Thu, 16 Mar 2006 13:28:56 -0800
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
In-Reply-To: <200603162117.k2GLHAvU021040@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
	 <20060316160129.GB6407@infradead.org>
	 <20060316082951.58592fdc.rdunlap@xenotime.net>
	 <200603162117.k2GLHAvU021040@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Or goes off the deep end and does something like:
>
> enum bool = {false, true, unknown};

Sounds like some of my AI code.
