Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423212AbWJYK1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423212AbWJYK1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423213AbWJYK1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:27:31 -0400
Received: from web23113.mail.ird.yahoo.com ([217.146.189.53]:39837 "HELO
	web23113.mail.ird.yahoo.com") by vger.kernel.org with SMTP
	id S1423212AbWJYK1a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:27:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZmwNv5sJKYBC/JnzK+FS/dVY5g2nl0YI9iKsEKDz12v50DewFsReEwcT46/zKSj18w9uUSS3fitZVt3zqivwVtM1DFEF7tVVjOP+1gU/Cx6MFyk90CWrR5OTAgvvsTLezC7nz8VhbPIV9FHbTKvYwEYzPpdKlXPipj5i/mbr3ws=  ;
Message-ID: <20061025102726.75828.qmail@web23113.mail.ird.yahoo.com>
Date: Wed, 25 Oct 2006 12:27:26 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [CRYPTO] Use aes hardware crypto device from userspace
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
