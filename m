Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTBXNtC>; Mon, 24 Feb 2003 08:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbTBXNtB>; Mon, 24 Feb 2003 08:49:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12928
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267083AbTBXNtB>; Mon, 24 Feb 2003 08:49:01 -0500
Subject: Re: 2.4.20-ac1 not seeing IDE disk on PIIX host adapter
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030224133058.GA25483@torres.ka0.zugschlus.de>
References: <20030222085102.GA23966@torres.ka0.zugschlus.de>
	 <1045946551.5484.2.camel@irongate.swansea.linux.org.uk>
	 <20030224133058.GA25483@torres.ka0.zugschlus.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046098819.1371.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 24 Feb 2003 15:00:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 13:30, Marc Haber wrote:
> Since we run 2.4.20ac1 on a bunch of production boxes (needing promise
> 20277 support), is the bug you are talking about a problem that should
> make us upgrade before 2.4.21 release?

Not really. In certain cases 2.4.20-ac1 could forget to check if a controller
have drives, thats all

