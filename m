Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292800AbSCDTPK>; Mon, 4 Mar 2002 14:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292796AbSCDTPB>; Mon, 4 Mar 2002 14:15:01 -0500
Received: from ns.suse.de ([213.95.15.193]:26632 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292779AbSCDTOq>;
	Mon, 4 Mar 2002 14:14:46 -0500
Date: Mon, 4 Mar 2002 20:14:35 +0100
From: Dave Jones <davej@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Andrey Panin <pazke@orbita1.ru>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swapfile.c
Message-ID: <20020304201434.D23524@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Robert Love <rml@tech9.net>, Andrey Panin <pazke@orbita1.ru>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200203022125.VAA144817.aeb@cwi.nl> <20020304112824.GA279@pazke.ipt> <1015267692.15277.13.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1015267692.15277.13.camel@phantasy>; from rml@tech9.net on Mon, Mar 04, 2002 at 01:48:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 01:48:08PM -0500, Robert Love wrote:
 > > Fixed in -dj tree.
 > Eww, nice spotting Andries.  If it is in the -dj tree, someone want to
 > push that bit to Linus?

 Actually, I only just applied that to my tree last night.
 Possibly Andrey was mixing it up to the IS_ERR fix that went in
 a while ago..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
