Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265061AbSJaAux>; Wed, 30 Oct 2002 19:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265062AbSJaAux>; Wed, 30 Oct 2002 19:50:53 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:1736 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S265061AbSJaAuo>;
	Wed, 30 Oct 2002 19:50:44 -0500
Date: Thu, 31 Oct 2002 01:57:07 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [RFC] Pending bugfixes for 2.4.20 ?
Message-ID: <20021031005707.GA3903@werewolf.able.es>
References: <20021031002705.GA3587@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021031002705.GA3587@werewolf.able.es>; from jamagallon@able.es on Thu, Oct 31, 2002 at 01:27:05 +0100
X-Mailer: Balsa 2.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


On 2002.10.31 J.A. Magallón wrote:
> Hi all.
> 
> We are in -rc, so only bugfixes ;)
> I have this collection of things posted in LKML as bugfixes, that still
> apply on top of rc1. Could you include if appropiate for next -rc, plz ?
> 

Opps, patches missing... attached.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc1-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))

--BOKacYhQ+x31HxR3
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="09-self_exec_id.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWY9mo/kAAGRfgAAwSP///3zmCIC/79/qQAHaud1icNJpRk2o0AGTRkyDQDTE
ZDagBkQTCTR6FNDJ6jJoAAADRpoNU/SKeptQND1Gg9QAaAAAAASSEEno02ppqeUMmgNA00AA
xHqIBMQIYGkcNJKKWAgBQ/YhdtD8UJN6k6FrUYIwZkYVcAAmARMGFrN+BF0mYNSCfihiUB18
5lnQdtqxUA+gQ3QippdOjffJYusJZiXJPRbWIoyByiIQ8IZSQXBiBix6e+/fzsroZAYmW1bB
rMNzM7SWq5T6SUvBjdUGoJdba2UbBpA6YBKc6ZWQcTyByKW0ZUBlQlODZJMaoBEk5NDro7nl
wpgtANKFYs/KA84LzxGkwJ+wSKRQPBdwzCA2Ze+muMJRhKNO34xVIC/SEppdo+yz3AqXZWlG
Cuw5DEq2n7odctqHwkBqDL00qboAbNrq3+xs68pVXjQ2UHEBF1NAV5FGlsw8rGFFdRuaRY/j
C58QqtV9CzWgws4PsUX0BldJqCuYiDOBgGdNgkkmYMRoiwcoaJbSHATUWF7Z1PClYIUp1apD
KgF24PMI1Coi5HwKhL2TdjMMSTTKFiK2pNXo5L6WZQoRhbj3pPbaXF9zX2ZDv9QEMVKwHRN4
FpGFbQ7+LuSKcKEhHs1H8g==

--BOKacYhQ+x31HxR3
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="02-printk.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWTTCFMAAADLfgEIwSH//fUAgEAC/795wMAE6kmGpoU8miGTyZTRoGTQ0aA2k
KTQNADQAAAAZDBKmJBqeFT9U8oNPIgAyPUPUNH0JZU03M+yeekHpND2UPDV/2lTupXrgm8Sf
vxO/IWin8HVuh9WCJp5FUpz+trzH4HdZWOSTUCBzUOsjAKDwUw3kBtSvpUszL7Dq252qfztl
CYVEEEJETEYeQqMKcBhWE80fYJqQYhw3RjxHj5FpnIwPEXah0fefFsiuIwqStqFrtNcAznED
ER7ZWpF/fVP+hGBEtlOCHOpDnoKLrgMmGmBJE0sRsGZE5iUKjNfOiEhaDMrlFb3WBG5yRdRO
dhAxRwiDpE3RgW3X4JW3ZFyYsUnBbJpUeqZNb8dkLyDpDYNNF5XR0fc6OxmFQnBegFKFgsBX
VGgXckU4UJA0whTA

--BOKacYhQ+x31HxR3
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="03-clone-detached.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWfXbfYEAADhfgFAwYX//s2zuSAC/rd5EMADpZhKUxNQPSAaNAyAaGjTCABKI
p5IxA00GmgAaAAA0EpKPSPTRDIBoAGgGTQDyhiWnhJ5rsF9936Ny4VYFNS8ItQjE8k9aPFmL
eNI9kGsykY5x5IZ2y3WQIjgUmVe3clk4vL0QrLQyMVp9QJ8eApJzSUJDWGijWx4hz9Yw1FUo
SgXYhCiZR0nTVMZTsMKTvU/QNlKHBVtJCQHkm5ItRXSShFbhFHf2E84Rjx4Ew4mD0fEaNFAs
MYyFICJBhdSUcokHjkaLAtDzDXIZCwJWGLPwkBKl9CNUQoqTCMHkCBS/+LuSKcKEh67b7Ag=

--BOKacYhQ+x31HxR3
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="04-module-size-checks.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWZM+iwwAAGZfgEgwcu/+/mI/GQTv799eMAF022NCUknkh6hlM0mnkNTJ6AQP
UY0xTDJAShVP9JqYiD9QE9CAZGExGhpkaGgFVEEYhNqPUNGgyGgAGgAB5RnFRbFdgOI8RUR3
VWcJ+HSYQZQ/lYuWXI3WYfERQNJ/EpPz3mDPHfNSSVyOwP8jqjWPHTb4BJljxlFRAjyxz2P4
XEDxgQVocpKyqsWEY5bihG2BavRMKM1DE5Lxodi/DIjaohvZl9QxL0+hWoX1bCll7uuE0r5H
q0kY9xZJkmhAetS9E5CESilZiiRTLjbyW7sWFl9jVtSUFG0FERzgo6zuzT/VH2xTovnKr5xI
kRKbGrgP3hS8S1RpgXObxRRgjCK3AkEomdqo1oXFKuamc+ImrjwJ+/Sa/2ssRQiMLUugJGeM
LzNWpKFFMi6Jn/IxqMqokTJGlLJYx5DFBUgUkP1UwB0QEqkkArGycvOjIjnA5jlBS4clUifC
ZTAt30LqF7cVQUn0isP8XckU4UJCTPosMA==

--BOKacYhQ+x31HxR3
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="06-memparam.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWUGBppsAANXfgGAwQf//+nL2nLC/79/6QAJdtbKjVAlFPUap+lP0iaaGZI9T
9U00ND1GTQADygAaaU9CFPEyTepPU9J6hoaAADQNGmgBzTEyZNGEwTE0wCYBDBGBGASJI0qf
kxGmlPFMQ00G1MQaaNDaajQPKQAAWWtqZChwm4hDbZDak39uuF2b+GPo5c5RgY+EkkKF1Twc
05U3O9/0sjpnxRApFwzDzS21CQLv7d90VTLxXshdQYie0bO2BIGa6WVqT8mG+aKx9azPkC72
/u6S8YZakZ31WINOstWVpTqcsY4WM4dYlRd0rmBHMeYZ1s10GiCXQdXV9annb6KhsCk2AHlH
SUe/nrwLDCkkw8CIrzL51YXyJr6Kiyz9Imo5i/j50gNFWCpc7Ew1jCpwyIrfQ9z4DFROdhkd
rYsyaUoqnaMFt4IrgiVklisVe1sa5uc9hL07lHg1sW0g7jabfbQG1fo+K09YELXJcks0mwOv
FKakPDuTxRqRNBp6l5OjrTG9Xn812lv0Jo0nzazVVnayH3F0FJ0n8GQ8zLlFCnSGW3JBG9ls
v8SNqJI0POZ7r5jC0UijN43aAd91dTDeYQVKFiuRxLcf03FFapiaHfxjS1cZBw+OKeMVZfpF
GKSlhIgmXcxwOTBZQkCErF94pE95CsFFxkvF4GlhJLlxmqLJys065I7HWmTLEFdwwkQadQc5
xOVae9hLgSUIeRgLAZrUR7CASYMIiukYy9CGCwbzZaDiFzVGZomlTXesplS1lFtyGNlk41Gk
ijC45HKThVIiQpQUpOIlTCyO44cC7i0E1F97tmZ1E1kMi0UTxwSqwENFvSNv/i7kinChIIMD
TTY=

--BOKacYhQ+x31HxR3
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="07-cache-detection.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWTaEfPsABJHfgHqwe3//+3+t386//9/+UAXY82arMGqkAUoAMkihptNTaJ5D
IgxGgYNNBpMTTEPUDCaNMHMJoyNDQyGEaGQ00aADEZMgGEAwCRERTJPKem1T1PKbU9RjUyZA
ZGg0GQAAZABzCaMjQ0MhhGhkNNGgAxGTIBhAMAkkCZT0jQZAjQJlNPKNojR6mENpHqbUBo02
U2pmtLyAYNjZlIIEkwubY8jIaiCZCJgHBClSxSyG222DjkHKUxAhxSAYxNNDZLfLprEGn7Zv
9mv2TqaDg0cjQ2gsjTaTj2ozGPseZXo5Id7o5WGuWQT1zan00XOpWrsdflZbrtgWxjZVkI4Q
EMIREXSwj697DCCzegKBpFU9TB2gGvOJx3LhQZzyPoSWgY7ykUp+n3CisH7UFthnHdhJb6Qs
NDEbSSIg2cMxpvlV0ClbipUJeUnKZh4iZf5gjlMCZfMmTLFYxcW3kwSdIGYzaWGE2hNpjTuo
XG4l1kHkS8O4Jqg8/oxkKHWaXqi2mJdw3AzjCc61Fiqu1Q49zEEOsQ2mzgs4b33MfZkkZoGc
/YgxGYXkKqJA26B92WOfuOq0/6oQyBAx5mb5ubqbQzM2eIiW4mSB7t/WeF56Ja7S7qTQt977
UDWo5iBEMp061m5dRYBSND3RcRcFaqFOOT3nVCEhkIgBnkEzURFEiEgjKleOCiAIhvnkFk9H
FKabiozLwgXZYSKSYyyTluHmTU5zDMfE2D3k8lK4odcZQdLUJeUbXEY+QMKhPiQWY9JAJeOD
NyeznLVchg9IcfWeYXRaMu+7QNk6tocYbgvDe22j25GSxQjDOEiBa49RA6Oo5x8Sxet7MbjZ
kUkwCl5Ai4jj4jz0odifiPGMytrjkoEiSmu8MATpPeK6/KMw+CFlwzZXMSVwXhnMBgHrVcRD
hwNvozivLWpJaDRfLWrSrLpMq7czg+lyy55uxOqdAW2QufV6nDRqdeGaaeduYpRpLAEIVKXE
wozBR6sRYs9gapwvHYqIGXlbbY2TYIGgrJhpcIPkzWMLaHxThSpojZUzjijnQ+rVFzBJj1PE
V8OB7FKUoERqr5bZcIY00NmyR/GkZkHGJd5KUvx62svxR7AmtDJHkRtxxA0QHwN5E/iO/AOa
UkablQn5nn+liIn8+1dAXuXLFHHyuBK0EvTEpaDmjQMYW5+7YSB6LcEVqDGGoMCqKIvB8HQI
ZwSc4ZjkRYu9cxJJGfnDmtB/fFEDDvtD0MHs3/2zBvuVAzpDE+2hFB7f3Rvn6AiiPgWKPX2B
r9zyZIqB1kDO4/gaYe8RYfj7DT1r8mZL3dKCwCIMhnOsJovsNAfpASPaWI0pcoTmGwcnDzuF
DZAJDP7g3xUPQ0DTrW8es3h3gpLgZlKFigecjHwJlBjhLCjyVhLWEBVI1Q4eggnk2wcpIjVw
cSGIBs34klbYuIIIgWmMcZKmoHV892URp1spOKvjJqGIoTcQXpjXpJhSoFwQCGQxqLvsIb/A
JgcBeZhbUbKsA2ndKpMiMaQ1mGiGpEhMrUbwYlnMeAFpjQW1RxLylew3TIFS0WFoMSR12shu
RBESywwm9zIOoOoV4a14Df2nCOWg3gxEB/gnE6k7nkA6hifvGoD0hxYOXrGBbTgG3G4tOIVD
5xV47zUZOMoY6BpKYh5pZtXTiCWrLtDgRXKr5bCAzDPXMxANwXqqHIssS0SxvQymk4f6nDjY
nE6F0SZmsHcYX7TxLnLSAWOoXwS8TAytMErMTJhg1oIAPRQ6ZhgZmHWgXjGE0QVG5WTkrDED
zA1lUtJrhMnoJ5A2QMkFkC5ZiKIIvgPeLIUJawvOhJD/BBesRNpIKK5JHcOPg88G89sRI/8X
ckU4UJA2hHz7

--BOKacYhQ+x31HxR3
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="08-highpage-init.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWcunr9MAAGpfgAAwaX//+Wvj3AC/799KQAHas5QCKm1HqGjagMJtB6oBpgBG
E2o0yCUhT000U2ImEbQAEzQEYjJgBppTU9QaGgD1GmhoAAAABoJIkTSbIYTU8RMmgDQAaZAN
NJr7FUFCHjrUEqA8qKSSF2wSdssF2QgE2VUND5AxkIAGLqBG4gJoBcKcRth+uQoNDV057eWl
MbK7jjrzpCOUOBFVzkIpYCGoUUo1DHRnlCxnoQh4iN8ApDL+FFrWYnkiJMKaMYRkEb12iERK
ory9qXZ8ERPA766EhgIQiFOCeiu0mbnUQQF8cNruqFKq59BQFRwty5cGUGYVpMtJbMGo6jWP
rDYfJ7Gw2Gwc2m07Td0jZwnxKUYeMimIx3YCHOdpqTMeH4tYlUDIO5CSERrGSzE0plMw8Zy8
Uow7pxw1v5zFoJEpBahJCg3hGWY/M+90wYDcDwGV8nCZqC1FRRUkKMTGYmKS8nWC4uo98qry
Z0Vb1hwkpYECBdoGTrMaTIRSFavq6MYpMRThK5kVkmC8yLGTDEQuKzExaX4UmhL3+lCeL6vK
IgDuLv0CrIDD0mg66iIU+MKxi1VjOEvArsWN5MjkkB2Zh0WGeg4B4i3fvlvk5KXgw0jIlX+L
uSKcKEhl09fpgA==

--BOKacYhQ+x31HxR3--
