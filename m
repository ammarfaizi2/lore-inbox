Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289551AbSAVXbY>; Tue, 22 Jan 2002 18:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289558AbSAVXbP>; Tue, 22 Jan 2002 18:31:15 -0500
Received: from ns.suse.de ([213.95.15.193]:43785 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289551AbSAVXbH>;
	Tue, 22 Jan 2002 18:31:07 -0500
Date: Wed, 23 Jan 2002 00:31:03 +0100
From: Dave Jones <davej@suse.de>
To: Serguei Miridonov <mirsev@cicese.mx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console output for debugging
Message-ID: <20020123003102.I21203@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Serguei Miridonov <mirsev@cicese.mx>, linux-kernel@vger.kernel.org
In-Reply-To: <3C4DF2AD.66BC3F6C@cicese.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C4DF2AD.66BC3F6C@cicese.mx>; from mirsev@cicese.mx on Tue, Jan 22, 2002 at 03:15:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 03:15:57PM -0800, Serguei Miridonov wrote:
 > Q: Is there any function in the kernel which I can call
 > safely from a module to print debug message on the console
 > screen?
 > 
 > I don't want to use printk for some reasons.

Keith Owens made a patch that allowed direct rendering of text
to console.. I just put an old copy of it at
http://www.kernelnewbies.org/documents/videochar.txt

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
