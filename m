Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288184AbSANDOs>; Sun, 13 Jan 2002 22:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288234AbSANDOi>; Sun, 13 Jan 2002 22:14:38 -0500
Received: from codepoet.org ([166.70.14.212]:15793 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288184AbSANDOS>;
	Sun, 13 Jan 2002 22:14:18 -0500
Date: Sun, 13 Jan 2002 20:14:20 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb fix, fixed
Message-ID: <20020114031420.GA18525@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0201101827100.22287-100000@freak.distro.conectiva> <20020114025951.GA17592@codepoet.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20020114025951.GA17592@codepoet.org>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun Jan 13, 2002 at 07:59:51PM -0700, Erik wrote:
> On Thu Jan 10, 2002 at 06:30:07PM -0200, Marcelo Tosatti wrote:
> > 
> > Hi, 
> > 
> > So here it goes pre3.
> 
> Hi Marcelo,
> 
> This patch is needed to make radeonfb compile and work.
> It is based on an earlier patch on the list attributed to
> Ani Joshi, plus adds the needed devinit fix.

Oops.  That patch had some crap in it.  Lets try that again.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--bg08WKrSYDhXBjb5
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="radeonfb.patch.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWeQREvwABkz/gHo0n7/Yf//8f///9L/v30ZQBhjzTGa2uO4AAayCEkhNEkae
wqek9E2ibNU0AephDAAExpGRppoH6iMRMjIFMykNAAANBoAAAAAAAABmpEE00k00ZNHqH6oA
00z1TQ2o0000GTCND1ADQAcyaaGQAMRkGQA0wQMQDRpoAMgaABIkQGgmmpmppTTTIMgAAAAa
Bp6INNMQMnTy1JuBj0RjSGQ2k9/a2902MkONnt0zDYhbcs3ApBZGdtYqxWyokmvAkNrkCS0w
9vwC2dDKSm+/xmzk1lzdcjJdiyY6FhkiKroUpeJRROqKeXE3QFUdKqeXLItnnMJRGo9Xr3B0
NdM65rrso970f62KVk5OV11WLHSDopBZbHy2yckAuyDGwaYwaaaSRllZQzOezmgJIymSArcK
6xucm8SZOdywiR8qhH055CZvTcdh0kD/CcZ5ZjaG0P1RycShEgS4ACaSP6SOR1efaX2N+eg7
BcLtF42zwJnaaPUTOtTByF+ROsZTmYRNg0sTsFmb8+03vCQaSIG2Ceaz+iBCM8SmMASD9iTU
KfU9XR1y4ee2C1rgvvL7Z4RdW7SzufgbEkCYNIBjYCGMSG7znAwltMcTbe24Utl7HnwXq8D4
6DPz774YK4tK8fNafa7PekTpF1LIGATDJOQclfwlKsNum3O6mE8lFEVVrbLceUNjNEjqB6If
6HXSONSGD8YE6mxjYQJ0illrNP+6pIObGHPekSVU4dTaikS2xMyCVmMUk0MY0IrpJFM34eOj
AJTt7Hr3tMjig4vY9XcjpuH+ZMPynLtk+lrpyeZTukVG/qTATmdmf09DIJiHjljnoslEKCGN
U45LhstsffrVfphOQ1YOtO+oAeASE79WBDKr1X0Yclxa0wRhitF4g4sSQGjUEbD066UolTJ5
gbCx4kIIZkBEzMrACAsBlc0oIzqQhBUBVQop2aITFPNBrjE6Y2QnK4JcpgU3m2c3GpmgoCm0
QGqX9wpCqSFxCBkGkg2b3At7EBlmIaaty6lCIy6jsjStJXsdc/CWI6avxgyoc6a8LQcc4x2V
6XdJDIO+zCszbO924IwmJFKoODYLuMKLBP7TAlKIHAxyJTrYmTMCFBOBGCtrOJXAYCqaBsYx
mRcF9nF0PZMZY4mSkO3BODArBcFWXF5F9xsQTTuCFsriV10OvlYs1oWuZoZ+HJVqU0a0oy6s
wNSJDBmRXWS3GpzG/U5X9F5MDiYqiyDTKKEpBKSVuDTGJcaFymYLS4BzxTQTrGXVrAF7TFaT
QXNqwIhtWCvYVooJmBJEKpGww1ZH3DhlfiOcxWzQ9wgsLBpk2cFnwrYZLGcQ4tCDkPYho4Mw
5iwgpv6LlpuJkt6aeZA5Rfu2rzz0kctqzUboU2HRj4FyhkpJhZUuKtqq4O0SmTQwsrC3hDvt
taLM295IYuRS1WtNVFmRVJDlgFSNichLgNI6Vng8Sy4kylUhwk5KBW46GNdBkxBiKZcsiqW6
YzaKN1YyM+OhJbwz1WGUJBvUkQWEKwdMyscy2Ze0V4ovwswvut55vQ1ZKwV5Zmpq6uVUSqmW
tkyMbZHOY1wIwDB4WAIyYjX1mNhBbme4LBy2BaRbAGqvUdbsZU45RbLm0L6gwKZZrZlmcDZX
SNxrUO916TI5RRLAha/ig8Z7xrxaMaZ1Piq+2ILDUYuEC+hcv9T0H+bILpqoPnfQbJYX5fWP
H/cIiLkZyixAgYC9C4eyd4CzmQIPHzeTk5ckCDkhoRzqYEPa5n0MjaiCW4q/uUfGgQUBrkHV
8AeZiBkeML0CDQCYSW9BhgB35HUQcsxr/F1g1DNoEEIJG0CKkEwKwL2haCOc8pF81edAeJhM
+J9BZBQNgOveB5NAtaMwN0hFq3MRQ5kKSRBZ7FIcBAC4TAY9IGYFwDOEkQui7hdyRThQkOQR
Evw=

--bg08WKrSYDhXBjb5--
