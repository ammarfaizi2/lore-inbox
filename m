Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbUK0Eku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbUK0Eku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbUK0EhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:37:00 -0500
Received: from mail.dnm.gov.ar ([200.55.54.66]:5772 "EHLO mail.dnm.gov.ar")
	by vger.kernel.org with ESMTP id S262221AbUK0Eg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 23:36:26 -0500
Message-ID: <41A804CD.5070007@migraciones.gov.ar>
Date: Sat, 27 Nov 2004 01:38:37 -0300
From: Javier Villavicencio <javierv@migraciones.gov.ar>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: no entropy and no output at /dev/random  (quick question)
References: <41A7EDA1.5000609@migraciones.gov.ar>
In-Reply-To: <41A7EDA1.5000609@migraciones.gov.ar>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Villavicencio wrote:
 >
 > # cat /dev/random (5 minutes, the server working, nothing)
 > ctrl+c
 > # cat /dev/urandom
 > <snip> (lots of randomness)

Playing with my desktop machine (which is newer and completely different 
from the servers) I've found that I run out of entropy -REALLY FAST-, 
even this one is supposed to have those hardware random stuff generators.

Is this a normal behaviour?, or, I think i've readed this somewhere, 
it's encouraged to use /dev/urandom instead of /dev/random?

Salu2.

-- 

       Javier Villavicencio
      Administrador/Consultor
Direccion Nacional de Migraciones
      Ministerio del Interior
       Republica Argentina
