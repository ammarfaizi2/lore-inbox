Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273656AbRIQPsM>; Mon, 17 Sep 2001 11:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273655AbRIQPsD>; Mon, 17 Sep 2001 11:48:03 -0400
Received: from unimur.um.es ([155.54.1.1]:8328 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S273654AbRIQPry>;
	Mon, 17 Sep 2001 11:47:54 -0400
Message-ID: <3BA61CC0.C9ECC8A0@ditec.um.es>
Date: Mon, 17 Sep 2001 17:54:40 +0200
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.77 [es] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ext3 journal on its own device?
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I have been browsing the Ext3 source (version 0.0.7a), and it seems
impossible to use a block device as an Ext3 journal. Is that true?.

TIA.
-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
