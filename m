Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289008AbSAKTuk>; Fri, 11 Jan 2002 14:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290071AbSAKTua>; Fri, 11 Jan 2002 14:50:30 -0500
Received: from lila.inti.gov.ar ([200.10.161.32]:52966 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S290021AbSAKTuZ>;
	Fri, 11 Jan 2002 14:50:25 -0500
Message-ID: <3C3F4278.4BB38FFE@inti.gov.ar>
Date: Fri, 11 Jan 2002 16:52:24 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Paul Lorenz <p1orenz@yahoo.com>
CC: linux-kernel@vger.kernel.org, j.lumbroso@noos.fr
Subject: Re: Driver via ac97 sound problem (VT82C686B)
In-Reply-To: <20020111192345.9003.qmail@web20908.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Lorenz wrote:

> Jan 11 08:56:48 debian kernel: ac97_codec: AC97 Audio
> codec, id: 0x4144:0x5361 (Unknown)

Just a note: That's an Analog Devices codec and the model seems to be
posterior to AD1885.
My patch to ac97_codec will at least detect the manufacturer ;-)

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



