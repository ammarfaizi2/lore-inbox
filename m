Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312913AbSCZBe3>; Mon, 25 Mar 2002 20:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312914AbSCZBeU>; Mon, 25 Mar 2002 20:34:20 -0500
Received: from kirsti.kvarteret.uib.no ([129.177.162.235]:55977 "EHLO
	ttt.kvarteret.org") by vger.kernel.org with ESMTP
	id <S312913AbSCZBeE>; Mon, 25 Mar 2002 20:34:04 -0500
Date: Tue, 26 Mar 2002 02:33:38 +0100
From: =?iso-8859-1?Q?Kjetil_Nyg=E5rd?= <kjetiln@kvarteret.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Problems with booting from SX6000
Message-ID: <20020326023338.A6882@kvarteret.org>
In-Reply-To: <20020325211541.A30644@kvarteret.org> <E16pdMH-0001nv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
X-Scanner: exiscan *16pfqE-0001nE-00*bIRdrr4Xfow* (Det Akademiske Kvarter, Bergen, Norway)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 10:54:33PM +0000, Alan Cox wrote:
> > I had the correct option for mounting (in grub):
> > 	kernel <some kernel> ro root=/dev/i2o/hda6
> 
> That won't work. Grub/boot parser don't know /dev/i2o/hda6. Try 
> root=hexvalue

Where does I find the hexvalues for /dev/i2o/hda?

Are the hexvalues static if I insert a new ide harddisk or a scsi harddisk?


-- 
mvh
	Kjetil Nygård
__________________________________________________________________
Nestleder i friByte
Tlf: 41 47 43 37
