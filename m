Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVJDN0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVJDN0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVJDN0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:26:47 -0400
Received: from ns.solnet.cz ([193.165.198.50]:23745 "EHLO solnet.cz")
	by vger.kernel.org with ESMTP id S932293AbVJDN0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:26:46 -0400
X-AntiVirus: scanned for viruses by soLNet AVirCheck 2.0.31 (http://www.solnet.cz/avircheck)
Message-ID: <43428305.9060106@solnet.cz>
Date: Tue, 04 Oct 2005 15:26:29 +0200
From: Martin <martin.povolny@solnet.cz>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andreas Gruenbacher <agruen@suse.de>
Subject: NFSACL protocol extension for NFSv3
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUgICCWlpbU1NRhYWFC
 QkK1tbV8fHz///86/WVWAAAAAWJLR0QAiAUdSAAAAfdJREFUeJyNk0Fv2zAMhZlZSK4T7HLXYZdd
 bVDQrgIk+O4NTa8hpHLXbFiRvz/KbR2l24ApQA78TPKReoLLPw78BzjD38EZ6nn4A3xc4wRvAbyc
 AIcbcAaz/hTALUihBpW9przyGk0uGU1qwRmShg2ElELYHTagSpNxWszU9vtwBaEW78iLS4Hi2GTU
 2l6EUFFqMjSevGRRlOFZMLyITTF7YZ5EQgO0dyQFerLQW6Dfo2X2AvBhA8F09Xu2yJLHdURYRYUQ
 tYOV9biwAdUaBZEtI0o+NRkGaoK9s9bqJA3Q6bJ4XpZ7a31peyiImfydzbpieLeBBFT4HkULWetu
 MsQjdJF7l3zewAVm48ml2U8DQSgN2DkvdYopSy9l3EAnhTzqcv2gCxiu9wFLIUHRdfS6/NJcFA8k
 Wgy9/rP7fgUykFe5NCFZLI0Z5iF6e+Q8fSNuwWV/nLUrCqk6boFJ3mtrQl2LtADMrJqEF01ighZE
 ecyJUnTdXQvOXURmevz09H6ypQWawUsfSBwfx6bHL3PS+Sz2FC2OjdsBTh1mW/fICDcAzZTZ9ip6
 aIBeOrp9X0estroBLJAnWY7q0OuL+rnaqphZPZpD+zgB9urOoprRta+2+kq1sgahg8PTBurD3y2L
 GlS3C5fPz+Drj1CBqe5E8SOYLyv4DQWvW+fLp0dWAAAAAElFTkSuQmCC
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

sorry for bothering, just a question: is there a chance for NFSACL
from -mm tree to be merged into main tree soon?

I am especially interested in the nfsacl-umask.diff part (ignoring
umask in directories with default ACL).

Regards,

-- 
Mgr. Martin Povolný, soLNet, s.r.o.,
+420777714458, <martin.povolny@solnet.cz>

