Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275825AbRJFXgM>; Sat, 6 Oct 2001 19:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275827AbRJFXfw>; Sat, 6 Oct 2001 19:35:52 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:49333 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S275825AbRJFXfm>;
	Sat, 6 Oct 2001 19:35:42 -0400
Date: Sun, 07 Oct 2001 00:36:09 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anton Blanchard <anton@samba.org>, Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: %u-order allocation failed
Message-ID: <483005851.1002414968@[195.224.237.69]>
In-Reply-To: <Pine.LNX.3.96.1011007003803.18004D-100000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.3.96.1011007003803.18004D-100000@artax.karlin.mff.cuni
 .cz>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, 07 October, 2001 12:58 AM +0200 Mikulas Patocka 
<mikulas@artax.karlin.mff.cuni.cz> wrote:

> How do you know it? I showed a simple case where it may happen.

Do you know two order=0 allocations with the same GFP_ value
would not have also failed?

--
Alex Bligh
