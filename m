Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292678AbSBZShV>; Tue, 26 Feb 2002 13:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292659AbSBZSf2>; Tue, 26 Feb 2002 13:35:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49424 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292420AbSBZSei>; Tue, 26 Feb 2002 13:34:38 -0500
Message-ID: <3C7BD534.4080806@zytor.com>
Date: Tue, 26 Feb 2002 10:34:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Mike Fedyk <mfedyk@matchmail.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
In-Reply-To: <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> 
> All the deleted files, with the correct path(s), are now in the
> top directory file the file-system ../lost+found directory. They
> are still owned by the original user, still subject to the same
> quota. The disk space can't run out because you have simply moved
> files that didn't exceed the disk space before they were moved.
> 


Ummm... it never occurred to you why someone would delete files in the
first place?

	-hpa


