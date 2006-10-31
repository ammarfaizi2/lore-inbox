Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423010AbWJaJLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423010AbWJaJLc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423011AbWJaJLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:11:32 -0500
Received: from web23106.mail.ird.yahoo.com ([217.146.189.46]:2928 "HELO
	web23106.mail.ird.yahoo.com") by vger.kernel.org with SMTP
	id S1423010AbWJaJLb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:11:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=k/eeQbx/CytRqrZMyNL02+To47gRxKy0YTy6seZ1Gp+j9AiGpaTYIJkpbtWLgxslZ4ZdP6RLIHJhLxn3YeWgp+kRyo76+M+q8tg2a6iFmSAdz9o98cD9ci8PSdCV+hsYpU4Infc8s+S/Rc9a3u+s+r4g6iL45SfEiznNs48Inok=  ;
Message-ID: <20061031091126.37294.qmail@web23106.mail.ird.yahoo.com>
Date: Tue, 31 Oct 2006 09:11:26 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [CRYPTO] Use aes hardware crypto device from userspace [Try #2]
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need to make AES ciphering in a userspace application. My platform
has an integrated crypto engine which is used by the kernel through
the core cryptographic API.

Is it possible to export easily this hardware to userspace just by writing
a dumb driver that would rely on the core crypto API ?  Are there any
races issues ?

Thanks

Francis






	

	
		
___________________________________________________________________________ 
Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! 
Profitez des connaissances, des opinions et des expériences des internautes sur Yahoo! Questions/Réponses 
http://fr.answers.yahoo.com
