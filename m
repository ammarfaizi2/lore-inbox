Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264814AbRFSWSt>; Tue, 19 Jun 2001 18:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbRFSWSj>; Tue, 19 Jun 2001 18:18:39 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:19863 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264814AbRFSWS3>;
	Tue, 19 Jun 2001 18:18:29 -0400
Message-ID: <3B2FCFB3.3E0DCC6E@mandrakesoft.com>
Date: Tue, 19 Jun 2001 18:18:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Philip Blundell <philb@gnu.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Tomasz =?iso-8859-1?Q?K=B3oczko?=" <kloczek@rudy.mif.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20-pre4
In-Reply-To: <E15CS0l-0006co-00@the-village.bc.nu>  <3B2FC899.3F0105F1@mandrakesoft.com> <E15CTag-0000Eb-00@kings-cross.london.uk.eu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Blundell wrote:
> I don't think -fno-builtin has any bearing on whether gcc will emit calls to
> memcpy;

Good point.  The subject was about the compiler adding function calls to
code, and I started talking about the compiler removing them...

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
