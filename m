Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUHSOdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUHSOdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266256AbUHSOdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:33:04 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:54169
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266275AbUHSOcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:32:51 -0400
Message-ID: <4124BA10.6060602@bio.ifi.lmu.de>
Date: Thu, 19 Aug 2004 16:32:48 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: kernel@wildsau.enemy.org, diablod3@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner>
In-Reply-To: <4124A024.nail7X62HZNBB@burner>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:

> The GPL requires you not to impact the original authors' reputations, but this 
> is what SuSE is doing by publishing defective variants.

What a stupid claim. When I call cdrecord on SuSE 9.1, I can burn CDs and
DVDs as normal user, without root permissions, without suid, without ide-scsi,
using /dev/hdc as device.

And this just works fine. So where's the problem?

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

