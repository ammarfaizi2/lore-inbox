Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131560AbQKZO7t>; Sun, 26 Nov 2000 09:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131755AbQKZO7k>; Sun, 26 Nov 2000 09:59:40 -0500
Received: from quechua.inka.de ([212.227.14.2]:22084 "EHLO mail.inka.de")
        by vger.kernel.org with ESMTP id <S131560AbQKZO71>;
        Sun, 26 Nov 2000 09:59:27 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
Message-Id: <E1402nl-0004Se-00@calista.inka.de>
Date: Sun, 26 Nov 2000 15:29:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A1DAAAD.28786302@mandrakesoft.com> you wrote:
> If you mean preferring 'if ()' over 'ifdef'... Linus.  :)  And I agree
> with him:  code looks -much- more clean without ifdefs.  And the
> compiler should be smart enough to completely eliminate code inside an
> 'if (0)' code block.

Oh I see. Well... hmmm... I think I have no Oppionion about that :)

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
