Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315410AbSFEMDj>; Wed, 5 Jun 2002 08:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315412AbSFEMDi>; Wed, 5 Jun 2002 08:03:38 -0400
Received: from argo.anu.edu.au ([150.203.5.57]:26752 "HELO argo.anu.edu.au")
	by vger.kernel.org with SMTP id <S315410AbSFEMDi> convert rfc822-to-8bit;
	Wed, 5 Jun 2002 08:03:38 -0400
From: "Roger W. Brown" <bregor@anusf.anu.edu.au>
Reply-To: bregor@anusf.anu.edu.au
Organization: Australian National University
To: linux-kernel@vger.kernel.org
Subject: Re: Definition conflict in 2.4.19-pre?? code
Date: Wed, 5 Jun 2002 22:03:38 +1000
User-Agent: KMail/1.4.5
In-Reply-To: <200206051736.45920.bregor@sf.anu.edu.au> <20020605100229.GX1105@suse.de>
Cc: axobe@suse.de, akpm@zip.com.au
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206052203.38253.bregor@sf.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                  (  Original message deleted )
>
> Your kernel tree must be corrupted, there's no such change in later
> 2.4.19-pre. pre10 still uses two request wait queues.

  Yes indeed !!   My patch program trips and falls whenever it encounters the    
line: "\ No newline at end of file"   I hadn't noticed.  Sorry.

-- 
Roger Brown 
