Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132077AbRDGXsZ>; Sat, 7 Apr 2001 19:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132101AbRDGXsP>; Sat, 7 Apr 2001 19:48:15 -0400
Received: from zen.via.ecp.fr ([138.195.130.71]:13843 "HELO zen.via.ecp.fr")
	by vger.kernel.org with SMTP id <S132077AbRDGXsA>;
	Sat, 7 Apr 2001 19:48:00 -0400
Date: Sun, 8 Apr 2001 01:47:53 +0200
From: =?iso-8859-1?Q?St=E9phane_Borel?= <stef@via.ecp.fr>
To: linux-kernel@vger.kernel.org
Subject: ATM with kernel 2.4.x
Message-ID: <20010408014753.B7240@via.ecp.fr>
Mail-Followup-To: =?iso-8859-1?Q?St=E9phane_Borel?= <stef@via.ecp.fr>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, we're trying to make a ForeRunnerLE 155 card work and we face
several problems:
-with kernel 2.4.3, we get unresolved symbol as we insmod lec
-with kernel 2.4.0-2.4.2 the sytem hangs when we try to start the atm
softs (ilmid)

So it only works with kernel <= 2.4.0-test12. We're using atm-0.78.

Does anyone know the status of atm under 2.4.x ?

Thank you for your help.

-- 
Stef
