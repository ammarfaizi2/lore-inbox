Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVGZLrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVGZLrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 07:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVGZLrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 07:47:07 -0400
Received: from web25802.mail.ukl.yahoo.com ([217.12.10.187]:4514 "HELO
	web25802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261694AbVGZLrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 07:47:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tgVrqd14KiVkR6i58pDh9X3ZpicAoRzhBhUbyJSmV/Fa+JlTpEAQrEMr5ISf0yurLalg4SToQ0MtOZAqF7jH+oQmT0XPC21pORSTYvahrxJTPOO36NSCNgWGfSIv5Iq5tVOBn3ju/lSPRwlo79rAZQ7XuYmy1LyeqH0qzoTkc6Y=  ;
Message-ID: <20050726114705.54469.qmail@web25802.mail.ukl.yahoo.com>
Date: Tue, 26 Jul 2005 13:47:05 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [INPUT] simple question on driver initialisation.
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050726105557.GB1588@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

--- Vojtech Pavlik <vojtech@suse.cz> a écrit :

> > What is this field for ?
>  
> It is intended for identifying the device based on "location" in the
> system.
> 

hmm, sorry but I don't understand you. I initialised this field with
"pinpad/input0" but the only place I can grep or find it, is in
/proc/bus/input/devices. I don't see how it can be used for identifiying
the device...

thanks for your time

          Francis


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
