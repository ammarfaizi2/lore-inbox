Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132497AbRDWWgW>; Mon, 23 Apr 2001 18:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbRDWWgN>; Mon, 23 Apr 2001 18:36:13 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:33274 "HELO
	giants.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S132483AbRDWWgE>; Mon, 23 Apr 2001 18:36:04 -0400
To: pawel.worach@mysun.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i810_audio broken?
In-Reply-To: <3804336226.3622638043@mysun.com>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 24 Apr 2001 00:34:33 +0100
In-Reply-To: <3804336226.3622638043@mysun.com> ("Pawel Worach"'s message of "Mon, 23 Apr 2001 23:48:25 +0200")
Message-ID: <m3n197ur5i.fsf@giants.mandrakesoft.com>
User-Agent: Gnus/5.090002 (Oort Gnus v0.02) Emacs/21.0.100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pawel Worach" <pworach@mysun.com> writes:

> I was using mpg123 (xmms and c/o does exactly the same)
> if I run it like this Moby sounds very stupid... :)

i got the same problem when using mpg123 compiled with esd on my dell
workstation (which has a need to have set explictely to a clocking of
41194 via ftsodell option), compiling without esd seems fix the prob
for me.

-- 
Chmouel
