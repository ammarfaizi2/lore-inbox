Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWI1LqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWI1LqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWI1LqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:46:16 -0400
Received: from web26513.mail.ukl.yahoo.com ([217.146.177.60]:33929 "HELO
	web26513.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751846AbWI1LqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:46:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UBM76O3Ce6qqDRpguECA6CNOw5Lfgq5rS0X+eeLyPMdsyqZl6AM4beHj0FypW8EUGLt442OYorlh6laItGkl6iTdrrkhPr3ytTQm7KoWEowbMggeQP74bZUfWrMLIWu+61df525/T+fUDIujHrOssx6SWoBLVovJdqUTLcwN78w=  ;
Message-ID: <20060928114612.61955.qmail@web26513.mail.ukl.yahoo.com>
Date: Thu, 28 Sep 2006 13:46:11 +0200 (CEST)
From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [Alsa-devel] [PATCH] Reset file->f_op in snd_card_file_remove()
To: karsten wiese <annabellesgarden@yahoo.de>, Takashi Iwai <tiwai@suse.de>
Cc: mingo@elte.hu, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060928113906.20550.qmail@web26504.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- karsten wiese <annabellesgarden@yahoo.de> schrieb:
> i'm now running 2.6.18-rt3 + alsa-driver-1.0.13rc1 and problem seams to be gone.
> 
its alsa-driver-1.0.13rc3.

      Karsten


	

	
		
___________________________________________________________ 
Der frühe Vogel fängt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de
