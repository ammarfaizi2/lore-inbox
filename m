Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279609AbRJXVlH>; Wed, 24 Oct 2001 17:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279608AbRJXVlA>; Wed, 24 Oct 2001 17:41:00 -0400
Received: from bugs.unl.edu.ar ([168.96.132.208]:31958 "HELO bugs.unl.edu.ar")
	by vger.kernel.org with SMTP id <S279617AbRJXVkq>;
	Wed, 24 Oct 2001 17:40:46 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Mart=EDn=20Marqu=E9s?= <martin@bugs.unl.edu.ar>
To: <linux-kernel@vger.kernel.org>
Subject: howto see shmem
Date: Wed, 24 Oct 2001 18:40:16 -0300
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011024214017.E5B1D2AB49@bugs.unl.edu.ar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found out that /proc/meminfo doesn't have (at least that's my first 
thought) info about shared memory (it shows 0, even in heavy duty servers). 
ipcs also shows nothing, so how can I see the amount of shared memory being 
used?
Th mounted /dev/shmem device also shows 0 kb used (just in case).

Saludos... :-)

-- 
Porqué usar una base de datos relacional cualquiera,
si podés usar PostgreSQL?
-----------------------------------------------------------------
Martín Marqués                  |        mmarques@unl.edu.ar
Programador, Administrador, DBA |       Centro de Telematica
                       Universidad Nacional
                            del Litoral
-----------------------------------------------------------------
