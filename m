Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289487AbSBENKm>; Tue, 5 Feb 2002 08:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSBENKV>; Tue, 5 Feb 2002 08:10:21 -0500
Received: from ns.suse.de ([213.95.15.193]:9228 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289507AbSBENKO>;
	Tue, 5 Feb 2002 08:10:14 -0500
Date: Tue, 5 Feb 2002 14:10:13 +0100
From: Dave Jones <davej@suse.de>
To: Benjamin Pharr <ben@benpharr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: choice Help Sections
Message-ID: <20020205141013.A24679@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Benjamin Pharr <ben@benpharr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020205054709.GA3245@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020205054709.GA3245@hst000004380um.kincannon.olemiss.edu>; from ben@benpharr.com on Mon, Feb 04, 2002 at 11:47:09PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 11:47:09PM -0600, Benjamin Pharr wrote:
 > Has anyone else noticed the availability of only one help section in
 > "choice" blocks when using make menuconfig (and others maybe?)? 
 > The best example of this is selection of "Processor family". No matter
 > which option is highlighted when Help is selected, it always gives the
 > help for CONFIG_M386.

 Yes, the config tools still need some work. With Linus showing
 no sign of merging CML2 or anything else in the near future,
 someone knowledgable of how these work should probably take a 
 look at fixing them up.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
