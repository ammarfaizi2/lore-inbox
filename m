Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130391AbQK0Sqh>; Mon, 27 Nov 2000 13:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129826AbQK0SqR>; Mon, 27 Nov 2000 13:46:17 -0500
Received: from quattro.sventech.com ([205.252.248.110]:59146 "HELO
        quattro.sventech.com") by vger.kernel.org with SMTP
        id <S129748AbQK0SqH>; Mon, 27 Nov 2000 13:46:07 -0500
Date: Mon, 27 Nov 2000 13:16:06 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Thomas Sailer <sailer@ife.ee.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.4.0-testx: USB Audio
Message-ID: <20001127131605.Z7764@sventech.com>
In-Reply-To: <200011271735.eARHZGZ05973@eldrich.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <200011271735.eARHZGZ05973@eldrich.ee.ethz.ch>; from Thomas Sailer on Mon, Nov 27, 2000 at 06:35:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000, Thomas Sailer <sailer@ife.ee.ethz.ch> wrote:
> This patch adds a workaround for the Dallas chip; the chip tags
> its 8bit formats with PCM8 but expects signed data.
> 
> Also, the driver is less verbose; I forward ported Alan Cox's changes
> in 2.2.18pre

Could you please send 2.4 USB patches to me? I'll get them sent to Linus
for inclusion into the kernel.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
