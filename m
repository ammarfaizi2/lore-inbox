Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319172AbSIDOVY>; Wed, 4 Sep 2002 10:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319181AbSIDOVY>; Wed, 4 Sep 2002 10:21:24 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:20212
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319172AbSIDOVX>; Wed, 4 Sep 2002 10:21:23 -0400
Subject: Re: writing OOPS/panic info to nvram?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Remco Post <r.post@sara.nl>, morten.helgesen@nextframe.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020904140856.GA1949@werewolf.able.es>
References: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl> 
	<20020904140856.GA1949@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 15:25:39 +0100
Message-Id: <1031149539.2788.120.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 15:08, J.A. Magallon wrote:
> Instead of swap, let user specify a partition to raw dump there. If a user
> wants crash dumps, he has to leave some small disk space free and give an
> option like "dump=/dev/hda7".

With what will you write it - not the linux block layer thats for sure.
Ingo has patches for doing network dumps which are kind of neat

