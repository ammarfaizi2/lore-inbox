Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311362AbSCSOmP>; Tue, 19 Mar 2002 09:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311363AbSCSOmF>; Tue, 19 Mar 2002 09:42:05 -0500
Received: from www.wen-online.de ([212.223.88.39]:18439 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S311362AbSCSOlr>;
	Tue, 19 Mar 2002 09:41:47 -0500
Date: Tue, 19 Mar 2002 15:58:39 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: John Jasen <jjasen1@umbc.edu>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
In-Reply-To: <Pine.SGI.4.31L.02.0203190915250.7550126-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.LNX.4.10.10203191555180.5833-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, John Jasen wrote:

> Sorry, I lost track of attributions. Need more coffee,
> 
> 
> > > 16:42:49.412862 10.0.0.101.netbios-dgm > 10.255.255.255.netbios-dgm:
> > > >>> NBT UDP PACKET(138) Res=0x1102 ID=0x54 IP=10.0.0.101 Port=138 Length=193
> > > Res2=0x0
> > > SourceName=T1H6I3          NameType=0x00 (Workstation)
> > > DestName=
> > > SMB PACKET: SMBunknown (REQUEST)
> > > SMB Command   =  0x43
> > > Error class   =  0x46
> > > Error code    =  20550
> > > Flags1        =  0x45
> > > Flags2        =  0x4E
> > > Tree ID       =  17990
> > > Proc ID       =  18000
> > > UID           =  16720
> > > MID           =  16707
> > > Word Count    =  66
> > > SMBError = ERROR: Unknown error (70,20550)
> 
> This looks like standard SMB garbage. It probably repeats on a regular
> basis. From what I remember, I think it is a Windows box browsing
> the network trying to discover other SMB boxes, finding a 'master
> browser', and other such stuff.

Yeah, this part is normal loking junk.  The abby-normal looking
bit got snipped :)

	-Mike

