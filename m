Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSE0Kax>; Mon, 27 May 2002 06:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316568AbSE0Kaw>; Mon, 27 May 2002 06:30:52 -0400
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:44994 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S316542AbSE0Kav>; Mon, 27 May 2002 06:30:51 -0400
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <acsuv2$30v$1@ID-44327.news.dfncis.de>
Mail-Followup-To: Andreas Hartmann <andihartmann@freenet.de>,
 linux-kernel@vger.kernel.org
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Mon, 27 May 2002 12:28:25 +0200
Message-ID: <87661951h2.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann <andihartmann@freenet.de> writes:

> Unfortunately, the memory management of kernel 2.4.x didn't get
> better until today. It is very easy to make a machine dead. Take the
> following script:

Use an -ac kernel with disabled overcommitment.

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
