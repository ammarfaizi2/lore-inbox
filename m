Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132957AbRAJBsG>; Tue, 9 Jan 2001 20:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132967AbRAJBr4>; Tue, 9 Jan 2001 20:47:56 -0500
Received: from zen.via.ecp.fr ([138.195.130.71]:45064 "HELO zen.via.ecp.fr")
	by vger.kernel.org with SMTP id <S132957AbRAJBrs>;
	Tue, 9 Jan 2001 20:47:48 -0500
Date: Wed, 10 Jan 2001 02:47:44 +0100
From: Stéphane Borel <stef@via.ecp.fr>
To: linux-kernel@vger.kernel.org
Subject: IBM Netfinity with 2.4.0
Message-ID: <20010110024744.A26255@via.ecp.fr>
Mail-Followup-To: Stéphane Borel <stef@via.ecp.fr>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have two Netfinity (7100 with 4 Xeon and 4500R with two PIII) and we
have noticed a weird behaviour with kernel 2.4.0 test and final.

*On the 7100, the final kernel can't detect two pci card (3C980 and
ForeRunnerLE.
*On the 4500R, the test kernel crash unexpectedly in two or three hours

And we have had two hard drive crashes with the serveraid cards that
resulted in a unusable filesystem.

Does anyone know if these are known issues of 2.4 kernels or if it may
be caused by another problem ?

The systems work with 2.2 kernels but we would like to use 2.4 for atm
support.

Thank you for your help.

-- 
Stef
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
