Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292503AbSBZR5v>; Tue, 26 Feb 2002 12:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292485AbSBZR5f>; Tue, 26 Feb 2002 12:57:35 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36614 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292478AbSBZR44>; Tue, 26 Feb 2002 12:56:56 -0500
Date: Tue, 26 Feb 2002 14:56:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "Rose, Billy" <wrose@loislaw.com>
Cc: "'Martin Dalecki'" <dalecki@evision-ventures.com>,
        Mike Fedyk <mfedyk@matchmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: ext3 and undeletion
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com>
Message-ID: <Pine.LNX.4.44L.0202261456010.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Rose, Billy wrote:

> My company can tolerate 0% loss of data (which is why I raised this issue).

> The ability to handle situations like a file going "poof" is why my
> company will not use Linux on these particular file servers. My aim was
> to change that by crushing the only thing holding Netware in my company.

You could use LVM snapshots.

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

