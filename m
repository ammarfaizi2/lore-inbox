Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316616AbSFDTVp>; Tue, 4 Jun 2002 15:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316617AbSFDTVo>; Tue, 4 Jun 2002 15:21:44 -0400
Received: from h64-251-67-69.bigpipeinc.com ([64.251.67.69]:38154 "HELO
	kelownamail.packeteer.com") by vger.kernel.org with SMTP
	id <S316616AbSFDTVo>; Tue, 4 Jun 2002 15:21:44 -0400
From: "Stephane Charette" <scharette@packeteer.com>
To: "Brett Dikeman" <brett@cloud9.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 04 Jun 2002 12:21:44 -0700
Reply-To: "Stephane Charette" <scharette@packeteer.com>
X-Mailer: PMMail 2000 Standard (2.10.2010) For Windows 2000 (5.0.2195;2)
In-Reply-To: <a05111705b922b09b689a@[10.1.0.123]>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: 2.4.18 assertion failure in journal_commit_transaction
Message-Id: <20020604192144Z316616-22651+75074@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>kernel that came with the distro(versioned 2.4.18-3; -4 is out, but I 
>reviewed the changelogs and it didn't look like they did anything 
>that would affect this problem, but I really couldn't tell.)  ext3 
>for all filesystems, hardware raid 0+1 via the Compaq controller.

Didn't RH 2.4.18-4 fix an ext3 bug on SMP?

http://rhn.redhat.com/errata/RHBA-2002-085.html

Is this related to what you saw?

Stephane Charette


