Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbULCMey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbULCMey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 07:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbULCMey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 07:34:54 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:48662 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262185AbULCMex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 07:34:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=e9m1c5jZwlsFCaCTaQZ95/H7Vz7xvMeVZQSiTsZjo3kJIOv7QMiJyovxQZpjoDRippaDFl1/WbhLStYez5v24nKzapX/3/IrGDoyMQNlXt5GpKLOFM6MBp9HkTTO3zVttVjg9MvDiFJUt0Ysm+YUiOiCqjAssDUwmp5aN6pEVok=
Message-ID: <aec7e5c304120304346e33dbd5@mail.gmail.com>
Date: Fri, 3 Dec 2004 13:34:52 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: ram mohan <madhaviram123@yahoo.com>
Subject: Re: Contribute - How to
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20041203043932.57460.qmail@web90004.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41AFEB48.60800@osdl.org>
	 <20041203043932.57460.qmail@web90004.mail.scd.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 20:39:32 -0800 (PST), ram mohan
<madhaviram123@yahoo.com> wrote:
> I was wondering how can I contribute in embedded
> without actual hardware.

Use an emulator such as QEMU! It might not be suitable for all kinds
of kernel development, but it is very useful to catch high level bugs.
Use it to test the your embedded distribution with different amounts
of RAM,  use it to test serial consoles etc. I will never leave home
without it.

/ magnus
