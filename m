Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313470AbSDGUeJ>; Sun, 7 Apr 2002 16:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313471AbSDGUeI>; Sun, 7 Apr 2002 16:34:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45576 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313470AbSDGUeH>; Sun, 7 Apr 2002 16:34:07 -0400
Subject: Re: Two fixes for 2.4.19-pre5-ac3
To: mulix@actcom.co.il (Muli Ben-Yehuda)
Date: Sun, 7 Apr 2002 21:51:19 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        movement@marcelothewonderpenguin.com (John Levon),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <20020407232339.B10733@actcom.co.il> from "Muli Ben-Yehuda" at Apr 07, 2002 11:23:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uJd9-0006h3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> userspace. What if such a mechanism existed, however, and was only
> exported to modules with a suitable license (modules which don't taint
> the kernel). Would that be feasible?

I think I'd rather discourage it. There are times its appropriate but very
few. Better that people figure out the right approach

Alan
--
	"Who killed more Americans - Al Queda or the cigarette industry ?"
					-- Anon

