Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbTFMNWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 09:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbTFMNWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 09:22:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34481
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265393AbTFMNWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 09:22:07 -0400
Subject: Re: Kernel comile problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vincent Fourmond <fourmond@clipper.ens.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.44.0306131422120.22593-100000@clipper.ens.fr>
References: <Pine.SOL.4.44.0306131422120.22593-100000@clipper.ens.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055511216.5162.55.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jun 2003 14:33:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-13 at 13:38, Vincent Fourmond wrote:
>   Hello !
> 
>   I have encountered few troubles while compiling the 2.4.20-7 debian
> (testing) version of teh Linux Kernel. I got one compiling error
> 
> ide-cd.h:440: error: long, short, signed or unsigned used invalidly for
> `slot_tablelen'

Your changes look ok but the linux kernel 2.4.x isnt yet clean for
building with gcc 3.3

