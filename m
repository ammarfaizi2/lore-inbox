Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbVKVUni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbVKVUni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 15:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbVKVUnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 15:43:37 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:52540 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965175AbVKVUng convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 15:43:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XjZ2h+NufIRQHPBcHroWXAAp59ZL29ki4RzKycoitVEPl9paJxW3GzcTj/3tsot6bKkXZJxR4uzW9l3BVZc6BVEkl2V0xhPgXntRaruQWqeFjPsqvMzBSzeVtDNfdNXLZtSI1PDcGjfE5zeDYqGBcynjGZ4LGID9b6HJ2oBgrd8=
Date: Tue, 22 Nov 2005 21:43:27 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Avi Kivity <avi@argo.co.il>
Cc: jgarzik@pobox.com, jonsmirl@gmail.com, benh@kernel.crashing.org,
       alan@lxorguk.ukuu.org.uk, airlied@gmail.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-Id: <20051122214327.37b902e4.diegocg@gmail.com>
In-Reply-To: <43837AD1.7060504@argo.co.il>
References: <20051121225303.GA19212@kroah.com>
	<20051121230136.GB19212@kroah.com>
	<1132616132.26560.62.camel@gaston>
	<21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	<1132623268.20233.14.camel@localhost.localdomain>
	<1132626478.26560.104.camel@gaston>
	<9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
	<43833D61.9050400@argo.co.il>
	<20051122155143.GA30880@havoc.gtf.org>
	<43834400.3040506@argo.co.il>
	<20051122172650.72f454de.diegocg@gmail.com>
	<438348BB.1050504@argo.co.il>
	<20051122204910.a4bd1d1e.diegocg@gmail.com>
	<43837AD1.7060504@argo.co.il>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 22 Nov 2005 22:08:49 +0200,
Avi Kivity <avi@argo.co.il> escribió:


> None of the desktop Windows installations I'm aware of exhibit this. The 
> recent versions of Windows are fairly stable.

You don't seem to check frecuently windows help forums, where some people
speaks of nvidia as the number 1 "bluescreener"...

Lots of windows drivers _are_ crappy. It's just a fact - some companies
hire the wrong people. Some companies (like nvidia) get money from being
fast, not from stability. This is a good example from a microsoft
programmer about how some companies cheat the WHQL certification to
get faster drivers...
http://blogs.msdn.com/oldnewthing/archive/2004/03/05/84469.aspx

This one about silent install of drivers by "smart" installers is fun
too: http://blogs.msdn.com/oldnewthing/archive/2005/08/16/452141.aspx


> Many people have hyperthreaded CPUs today.

Hypertreaded CPUs can't run the two virtual cpus at the same time,
real smps can so the probability should be smaller (this would be an
interesting topic for another thread though ;)


> It works well on the server, where Linux has a large and rising market 

Linux didn't always have a large market share on servers. Again, history
has shown that the path taken by linux until now is succesful.
