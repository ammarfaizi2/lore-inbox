Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbQLLWBR>; Tue, 12 Dec 2000 17:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130151AbQLLWBH>; Tue, 12 Dec 2000 17:01:07 -0500
Received: from pop.gmx.net ([194.221.183.20]:23368 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129998AbQLLWBC>;
	Tue, 12 Dec 2000 17:01:02 -0500
Date: Tue, 12 Dec 2000 20:06:34 +0100
From: Matthias Czapla <dermatsch@gmx.de>
To: Guest section DW <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cdrom doesnt work anymore with 2.4
Message-ID: <20001212200633.A331@st3>
Reply-To: Matthias Czapla <dermatsch@gmx.de>
In-Reply-To: <20001212141704.A225@st3> <20001212161544.A2134@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001212161544.A2134@win.tue.nl>; from dwguest@win.tue.nl on Die, Dez 12, 2000 at 04:15:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, Dez 12, 2000 at 04:15:44 +0100, Guest section DW wrote:
> On Tue, Dec 12, 2000 at 02:17:04PM +0100, Matthias Czapla wrote:
> 
> > I have a quite old cdrom drive, called Cyberdrive 240D. With linux 2.2.17
> > it worked with soemtimes odd behavior, but it worked.
> > With 2.4.0-test11 I can mount cdroms in it but if I want to access it (eg.
> > ls, cd...) I get messages like:
> > _isofs_bmap: block >= EOF (1096810496, 2048)
> > or 
> > _isofs_bmap: block < 0
> 
> Fixed in 2.4.0-test12.
> 

Thanks. Its workign now :))

-- 
schüss,
Matthias Czapla
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
