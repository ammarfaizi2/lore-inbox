Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbUL0UFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbUL0UFM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUL0UFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:05:12 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:13783 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S261963AbUL0UEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:04:44 -0500
Message-ID: <41D06AD7.6010706@rnl.ist.utl.pt>
Date: Mon, 27 Dec 2004 20:04:39 +0000
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] pid randomness
References: <41D064D5.1030900@rnl.ist.utl.pt> <Pine.LNX.4.61.0412272047110.9354@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0412272047110.9354@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>I don't know if this has been discussed before... but I'd like to ask why isn't
>>the pids randomized by default?
>>What are the pros and cons of this? What are your oppinions on this subjet?
> 
> 
> Why would _you_ need it?

It's a simple security measure that I think is easy to implement.

I'd agree that it's not there because of the golden rule: "keep it 
simple", but I'd also like to know if that's really the reason it's not 
there.

and yes, I know there are some patch sets that already implement this.

regards,
pedro venda.
-- 
Pedro João Lopes Venda
email: pjvenda@rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administração de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior Técnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt
