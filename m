Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267440AbUHJGIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267440AbUHJGIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 02:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267442AbUHJGIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 02:08:35 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:37069
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267440AbUHJGIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 02:08:34 -0400
Message-ID: <41186660.9000403@bio.ifi.lmu.de>
Date: Tue, 10 Aug 2004 08:08:32 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FW: Linux kernel file offset pointer races
References: <XFMail.20040805104213.pochini@shiny.it>	 <Pine.LNX.4.58.0408051228400.2791@twin.jikos.cz>	 <411736CB.2040607@bio.ifi.lmu.de> <1092062710.14129.22.camel@localhost.localdomain>
In-Reply-To: <1092062710.14129.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> If you want a fix now grab the Red Hat or SuSE published fixes. The
> final stuff will probably look very different because Linus has
> proposed a different solution that makes it harder for new drivers to
> make the same mistakes again

Thank you very much for clarifying this!

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

