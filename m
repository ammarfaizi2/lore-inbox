Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSEHDJQ>; Tue, 7 May 2002 23:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315493AbSEHDJP>; Tue, 7 May 2002 23:09:15 -0400
Received: from mail-infomine.ucr.edu ([138.23.89.48]:34990 "EHLO
	mail-infomine.ucr.edu") by vger.kernel.org with ESMTP
	id <S315491AbSEHDJO>; Tue, 7 May 2002 23:09:14 -0400
Date: Tue, 7 May 2002 20:09:10 -0700
To: Tomasz Rola <rtomek@cis.com.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't Burn CDR's On 2.4.19pre8
Message-ID: <20020508030910.GA16687@mail-infomine.ucr.edu>
In-Reply-To: <20020507212201.GA12699@mail-infomine.ucr.edu> <Pine.LNX.3.96.1020508040909.2702J-100000@pioneer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
From: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Tomasz Rola:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Tue, 7 May 2002, Johannes Ruscheinski wrote:
> 
> > Also sprach Tomasz Rola:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > On Mon, 6 May 2002, Johannes Ruscheinski wrote:
> > > 
> > > > Hi,
> > > > 
> > > > I don't know whether I have a hardware problem or a kernel problem.  Here's
> > > > what I get when I try to dummy burn a data CDR on 2.4.19pre8:
> > > > 
> > > 
> > > Forgive me this insulting question, but have you tried to burn another CD?
> > It was a dummy burn.  I didn't realize that the CDR medium mattered here?
> > So just to be on the safe side I tried again with a different brand disc
> > and had a failure after about 70MiB of data.
> 
> Me idiot. Haven't noticed that "dummy" word. How about going back to some
> previous working kernel to try if it works? I have burnt quite a few CDRWs
I don't know if there ever was a working kernel that's what I'd like to know.
How do I differentiate bad hardware from a kernel problem?
> under 2.4.18 so I assume it's ok here. BTW, I always give right dev=x,y,z
> options, which I get from "cdrecord -scanbus".
Actually I did too: "dev=0,0,0" as determined by "cdrecord -scanbus".
> 
> bye
> T.
> 
> - --
> ** A C programmer asked whether computer had Buddha's nature.      **
> ** As the answer, master did "rm -rif" on the programmer's home    **
> ** directory. And then the C programmer became enlightened...      **
> **                                                                 **
> ** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **
> 
> 
> -----BEGIN PGP SIGNATURE-----
> Version: PGPfreeware 5.0i for non-commercial use
> Charset: noconv
> 
> iQA/AwUBPNiKCBETUsyL9vbiEQKLmQCgjykrGtGsrdZxkwgegm/saT029DEAoNNm
> VeREzT/A9X6ga1D56XPZX2ly
> =HBJv
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Johannes
--
Dr. Johannes Ruscheinski
EMail:    ruschein_AT_infomine.ucr.edu ***          Linux                  ***
Location: science library, room G40    *** The Choice Of A GNU Generation! ***
Phone:    (909) 787-2279

"He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?"
                            -- Montgomery C. Burns
